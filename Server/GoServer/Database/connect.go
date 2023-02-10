package Database

import (
	"database/sql"
	"log"

	_ "github.com/go-sql-driver/mysql"
)

func ConnectToDatabase() (*sql.DB, error) {
	db, err := sql.Open("mysql", "<DB_username>:<DB_password>@tcp(<host>:3306)/<DB_name>")
	if err != nil {
		log.Println(err)
	}
	return db, err
}
