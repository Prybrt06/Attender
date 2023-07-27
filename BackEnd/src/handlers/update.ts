import prisma from "../db";



export const createUpdate = async (req, res, next) => {
	const id = req.params.id;

	const update = await prisma.update.create({
		//@ts-ignore
		data: {
			isAttended: req.body.isAttended,
			subjectId: id,
			belongsToUserId: req.user.id,
		},
	});

	// res.status(201);
	// res.json({ update: update });
};
