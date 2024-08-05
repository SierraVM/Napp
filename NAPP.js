const express = require('express');
const app = express();
const port = process.env.PORT || 80;


app.get('/', (req, res) => {
  res.send('Todo App');
});

app.listen(port, () => {
  console.log(`Todo app listening at http://localhost:${port}`);
});
