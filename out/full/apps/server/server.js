import express from 'express';
const app = express();
const port = process.env.PORT || 3000;
import { handler as marineHandler } from 'marine/server';
app.use(express.static('./marine/dist/client/'))
// Attach the Marine app bundle output to the correct path.
app.use('/marine', marineHandler);

app.get('/', (req, res) => {
  res.send('Hello')
})


app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at https://localhost:${port}`);
});