import express from 'express';
const app = express();
const port = process.env.PORT || 3000;
import { handler as marineHandler } from 'marine/server';
import { exec } from 'child_process';
app.use(express.static('./marine/dist/client/'))
// Attach the Marine app bundle output to the correct path.
app.use('/marine', marineHandler);

app.get('/', (req, res) => {
  res.send('Hello')
})


app.post('/webhook', (req, res) => {
  const { action, pull_request } = req.body;

  if (action === 'closed' && pull_request.merged && pull_request.head.ref === 'main') {
    exec('docker-compose up --build -d', (err, stdout, stderr) => {
      if (err) {
        console.error(err);
        res.sendStatus(500);
      } else {
        console.log(stdout);
        res.sendStatus(200);
      }
    });
  } else {
    res.sendStatus(200);
  }
});

app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at https://localhost:${port}`);
});