import { Router } from "express";
import { body } from "express-validator";
import {
	createSubject,
	deleteSubject,
	getAllSubject,
	getOneSubject,
	updateAttendence,
	updateSubject,
} from "../handlers/subject";
import { createUpdate } from "../handlers/update";

const subjectRoute = Router();

subjectRoute.get("/", getAllSubject);

subjectRoute.get("/:id", getOneSubject);

subjectRoute.post(
	"/create",
	body("name").isString(),
	body("subjectCode").isString(),
	createSubject
);

subjectRoute.put(
	"/markAttendance/:id",
	body("totalClasses").isInt(),
	body("attendedClasses").isInt(),
	body("isAttended").isBoolean(),
	updateAttendence,
	createUpdate
);

subjectRoute.put(
	"/update/:id",
	body("name").isString(),
	body("subjectCode").isString(),
	body("totalClasses").isInt(),
	body("attendedClasses").isInt(),
	updateSubject
);

subjectRoute.delete("/delete/:id", deleteSubject);

export default subjectRoute;
