import { Todo } from "../types/todo"
import { fetchAuthSession } from "aws-amplify/auth"

const API_BASE_URL = process.env.NEXT_PUBLIC_API_URL || "http://localhost:3001"

async function getAuthToken() {
	try {
		const session = await fetchAuthSession()
		return session.tokens?.accessToken?.toString()
	} catch (error) {
		console.error("Error getting auth token:", error)
		throw error
	}
}

export const todoApi = {
	async list(): Promise<Todo[]> {
		const token = await getAuthToken()
		const response = await fetch(`${API_BASE_URL}/todos`, {
			headers: {
				Authorization: `Bearer ${token}`,
			},
		})
		if (!response.ok) throw new Error("Failed to fetch todos")
		return response.json()
	},

	async create(title: string): Promise<Todo> {
		const newTodo = {
			title: title,
			completed: false,
		}
		const token = await getAuthToken()
		const response = await fetch(`${API_BASE_URL}/todos`, {
			method: "POST",
			headers: {
				"Content-Type": "application/json",
				Authorization: `Bearer ${token}`,
			},
			body: JSON.stringify(newTodo),
		})
		if (!response.ok) throw new Error("Failed to create todo")
		return response.json()
	},

	async delete(id: string): Promise<void> {
		const token = await getAuthToken()
		const response = await fetch(`${API_BASE_URL}/todos/${id}`, {
			method: "DELETE",
			headers: {
				Authorization: `Bearer ${token}`,
			},
		})
		if (!response.ok) throw new Error("Failed to delete todo")
	},
}
