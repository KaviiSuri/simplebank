package main

import (
	"database/sql"
	"log"

	"github.com/KaviiSuri/simplebank/api"
	db "github.com/KaviiSuri/simplebank/db/sqlc"
	"github.com/KaviiSuri/simplebank/util"

	_ "github.com/lib/pq"
)

func main() {
	config, err := util.LoadConfig(".")
	if err != nil {
		log.Fatal("Could not load config: ", err)
	}

	conn, err := sql.Open(config.DBDriver, config.DBSource)
	if err != nil {
		log.Fatal("Could not connect to database: ", err)
	}

	store := db.NewStore(conn)
	server := api.NewServer(store)

	err = server.Start(config.ServerAddress)
	if err != nil {
		log.Fatal("Could not start server: ", err)
	}
}
