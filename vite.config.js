import { defineConfig } from "vite";
import react from "@vitejs/plugin-react";

export default defineConfig(() => {
	return {
		plugins: [react()],
		test: {
			globals: true,
			environment: 'jsdom',
			setupFiles: './src/setupTests.ts',
		  },
	};
});
