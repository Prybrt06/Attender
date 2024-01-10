import { Router } from "express";
import { body } from "express-validator";
import {
	createSubject,
	deleteSubject,
	getAllSubject,
	getOneSubject,
	markAttendance,
	updateAttendence,
	updateSubject,
} from "../handlers/subject";
import { createUpdate } from "../handlers/update";
import { inputHandler } from "../handlers/inputHandler";

const subjectRoute = Router();

subjectRoute.get("/", getAllSubject);

subjectRoute.get("/:id", getOneSubject);

subjectRoute.post(
	"/create",
	body("name").isString(),
	body("subjectCode").isString(),
	inputHandler,
	createSubject
);

subjectRoute.post(
	"/markAttendance/:id",
	body("isAttended").isBoolean(),
	inputHandler,
	markAttendance,
	createUpdate
);

subjectRoute.put(
	"/update/:id",
	body("name").isString(),
	body("subjectCode").isString(),
	body("totalClasses").isInt(),
	body("attendedClasses").isInt(),
	inputHandler,
	updateSubject
);

subjectRoute.delete("/delete/:id", deleteSubject);

export default subjectRoute;
