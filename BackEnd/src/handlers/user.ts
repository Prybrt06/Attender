import prisma from "../db";
import { comparePasswords, createJWT, hashPassword } from "../modules/auth";
import { body, validationResult } from "express-validator";

export const createNewUser = async (req, res) => {
	const user = await prisma.user.create({
		// @ts-ignore
		data: {
			username: req.body.username,
			mail: req.body.mail,
			password: await hashPassword(req.body.password),
		},
	});

	const token = createJWT(user);
    res.status(200)
	res.json({ token });
};

export const signin = async (req, res) => {
	const user = await prisma.user.findUnique({
		where: {
			username: req.body.username,
		},
	});

	var isPasswordValid = await comparePasswords(
		req.body.password,
		user.password
	);

	if (!isPasswordValid) {
		res.status(401);
		res.json({ message: "invalid password" });
		return;
	}

	const token = createJWT(user);
	res.status(201);
	res.json({ message: "Signin successfully", token: token });
};
