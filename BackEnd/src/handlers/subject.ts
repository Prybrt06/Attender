import prisma from "../db";

// Get all subjects of a user
export const getAllSubject = async (req, res, next) => {
	const user = await prisma.user.findUnique({
		where: {
			id: req.user.id,
		},
		include: {
			subjects: true,
		},
	});
	const subjects = user.subjects;

	res.status(201);
	res.json({ subjects: subjects });
};

// Get a single subject of a user with the use of id
export const getOneSubject = async (req, res, next) => {
	const id = req.params.id;

	const subject = await prisma.subject.findFirst({
		where: {
			id: id,
			belongsToId: req.user.id,
		},
	});

	if (subject == null) {
		res.status(400);
		res.json({ message: "You have no subject with this id" });
		return;
	}

	res.status(201);
	res.json({ subject: subject });
};

// Create Subject
export const createSubject = async (req, res, next) => {
	const subject = await prisma.subject.create({
		data: {
			name: req.body.name,
			subjectCode: req.body.subjectCode,
			belongsToId: req.user.id,
		},
	});

	res.status(201);
	res.json({ subject: subject });
};

// Attended a class
export const updateAttendence = async (req, res, next) => {
	const id = req.params.id;

	const subject = await prisma.subject.update({
		where: {
			id_belongsToId: {
				id: id,
				belongsToId: req.user.id,
			},
		},
		data: {
			totalClasses: req.body.totalClasses,
			attendedClasses: req.body.attendedClasses,
		},
	});

	if (subject == null) {
		res.status(401);
		res.json({ message: "You don't have a subject with this id" });
		return;
	}

	res.status(201);
	res.json({ subject: subject });

	next();
};

//mark attendance
export const markAttendance = async (req, res, next) => {
	const id = req.params.id;

	const subject = await prisma.subject.update({
		where: {
			id_belongsToId: {
				id: id,
				belongsToId: req.user.id,
			},
		},
		data: {
			totalClasses: { increment: 1 },
			attendedClasses: { increment: req.body.isAttended ? 1 : 0 },
		},
	});

	res.status(201).json({ updatedSubject: subject });
	next();
};

// Update Subject Details
export const updateSubject = async (req, res, next) => {
	const id = req.params.id;

	console.log(id);

	const subject = await prisma.subject.update({
		where: {
			id_belongsToId: {
				id: id,
				belongsToId: req.user.id,
			},
		},
		data: {
			name: req.body.name,
			subjectCode: req.body.subjectCode,
			totalClasses: req.body.totalClasses,
			attendedClasses: req.body.attendedClasses,
		},
	});

	if (subject == null) {
		res.status(401);
		res.json({ message: "You don't have a subject with this id" });
		return;
	}

	res.status(201);
	res.json({ updatedSubject: subject });
};

// Delete a subject
export const deleteSubject = async (req, res) => {
	console.log("hello");
	const id = req.params.id;
	console.log(id);

	const subject = await prisma.subject.delete({
		where: {
			id_belongsToId: {
				id: id,
				belongsToId: req.user.id,
			},
		},
	});

	res.status(201);
	res.json({ deletedSubject: subject });
};
