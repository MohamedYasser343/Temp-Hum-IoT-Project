package Database

import (
	"database/sql"
	"log"

	_ "github.com/go-sql-driver/mysql"
)

func ConnectToDatabase() (*sql.DB, error) {
	db, err := sql.Open("mysql", "snap:Snapsnap@2@tcp(92.205.60.182:3306)/CapStone")
	if err != nil {
		log.Println(err)
	}
	return db, err
}
