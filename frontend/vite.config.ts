import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vitest/config'
import vue from '@vitejs/plugin-vue'

export default defineConfig({
  plugins: [vue()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url))
    }
  },
  server: {
    watch: {
      usePolling: true
    }
  },
  test: {
    environment: 'jsdom',
    reporters: ['default', 'junit'],
    outputFile: './test-report.xml',
    coverage: {
      provider: 'v8',
      reporter: ['text', 'lcov']
    }
  }
})