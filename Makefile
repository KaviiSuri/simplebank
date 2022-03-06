postgres:
	docker run --name simplebank-postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec simplebank-postgres createdb simplebank

dropdb:
	docker exec simplebank-postgres dropdb simplebank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@127.0.01:5432/simplebank?sslmode=disable" --verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@127.0.01:5432/simplebank?sslmode=disable" --verbose down
sqlc:
	sqlc generate

test:
	go test -v -cover ./...

.PHONY: createdb dropdb migrateup migratedown sqlc test
