import { z } from "zod"

export const createTodoInputSchema = z.object({
	title: z.string().min(1),
})
export type CreateTodoInput = z.infer<typeof createTodoInputSchema>

export const todoSchema = z.object({
	id: z.string().uuid(),
	title: z.string().min(1),
	completed: z.boolean(),
	createdAt: z.string().datetime(),
	updatedAt: z.string().datetime(),
})
export type Todo = z.infer<typeof todoSchema>
