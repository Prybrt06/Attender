import express from "express";
import morgan from "morgan";
import cors from "cors";

import subjectRoute from "./routes/subjectRouter";

import { protect } from "./modules/auth";
import { createNewUser, signin } from "./handlers/user";
import { body } from "express-validator";
import { inputHandler } from "./handlers/inputHandler";

const app = express();

app.use(cors());
app.use(morgan("dev"));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get("/", (req, res) => {
	res.status(200);
});

app.use("/subject", protect, subjectRoute);

app.post(
	"/user",
	body("username").isString(),
	body("mail").isString(),
	body("password").isString(),
	inputHandler,
	createNewUser
);

app.post(
	"/signin",
	body("username").isString(),
	body("password").isString(),
	inputHandler,
	signin
);

export default app;
