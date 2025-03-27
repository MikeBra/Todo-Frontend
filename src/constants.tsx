let apiHost = ""

if (!process.env.NEXT_PUBLIC_API_URL) {
	throw new Error("NEXT_PUBLIC_API_URL is not set")
} else {
	apiHost = process.env.NEXT_PUBLIC_API_URL
}

export { apiHost }
