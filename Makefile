createdb:
	sudo docker exec default-psql createdb simplebank

dropdb:
	sudo docker exec default-psql dropdb simplebank

migrateup:
	migrate -path db/migration -database "postgresql://postgres:secret@127.0.01:5432/simplebank?sslmode=disable" --verbose up

migratedown:
	migrate -path db/migration -database "postgresql://postgres:secret@127.0.01:5432/simplebank?sslmode=disable" --verbose down
sqlc:
	sqlc generate
.PHONY: createdb dropdb migrateup migratedown sqlc
