.PHONY: build build-frontend deploy-frontend test test-frontend run-api run-frontend clean

# Build all Lambda functions
build:
	./scripts/build-lambda.sh lambda-api

# Run Go tests
test:
	go test -v -race ./...

# Run Go tests with coverage (for CI)
ci-test:
	go test -v -race -coverprofile=coverage.out -covermode=atomic ./...

# Run frontend tests
test-frontend:
	cd frontend && npm run test

# Run frontend tests with coverage (for CI)
ci-test-frontend:
	cd frontend && npm run test:ci

# Build frontend for deployment (requires terraform outputs)
build-frontend:
	$(eval API_URL := $(shell terraform -chdir=terraform output -raw api_url))
	cd frontend && npm ci && VITE_API_BASE_URL=$(API_URL) npm run build

# Deploy frontend to S3
deploy-frontend:
	aws s3 sync frontend/dist s3://$$(terraform -chdir=terraform output -raw frontend_bucket) \
		--delete \
		--cache-control "max-age=31536000" \
		--exclude "index.html"
	aws s3 cp frontend/dist/index.html s3://$$(terraform -chdir=terraform output -raw frontend_bucket)/index.html \
		--cache-control "max-age=300"

# Run local API server
run-api:
	env $$(terraform -chdir=terraform output -raw app_env_vars) \
		LOG_LEVEL=trace \
		ALLOWED_ORIGIN=http://localhost:5173 \
		go run github.com/jonsabados/roshamboduel/cmd/standalone-api

# Run frontend dev server
run-frontend:
	cd frontend && npm run dev

# Clean build artifacts
clean:
	rm -rf dist/
	rm -rf frontend/dist/
	rm -rf frontend/node_modules/

# Generate mocks (when mockery is set up)
generate-mocks:
	go generate ./...