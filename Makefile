postgres:
	docker run --name simplebank-postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec simplebank-postgres createdb simplebank

dropdb:
	docker exec simplebank-postgres dropdb simplebank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@127.0.0.1:5432/simplebank?sslmode=disable" --verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@127.0.0.1:5432/simplebank?sslmode=disable" --verbose down

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@127.0.0.1:5432/simplebank?sslmode=disable" --verbose up 1

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@127.0.0.1:5432/simplebank?sslmode=disable" --verbose down 1

sqlc:
	sqlc generate

mock:
	mockgen -destination db/mock/store.go -package mockdb github.com/KaviiSuri/simplebank/db/sqlc Store

test:
	go test -v -cover ./...

server:
	go run main.go

.PHONY: createdb dropdb migrateup migratedown sqlc test server mock
