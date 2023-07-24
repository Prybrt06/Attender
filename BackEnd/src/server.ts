import express from 'express'
import subjectRoute from './router';

const app = express();

app.get("/", (req, res) => {
    res.status(200);
    res.json({message: "Hello"})
});

app.get("/subject",subjectRoute)

export default app