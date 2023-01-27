package Controllers

import (
	"GoServer/Database"
	"GoServer/Models"
	"log"
	"net/http"

	"github.com/gin-gonic/gin"
)

func GetAllData(context *gin.Context) {
	db, err := Database.ConnectToDatabase()
	if err != nil {
		context.JSON(400, gin.H{
			"message": "Can't connect to database",
		})
	}
	defer db.Close()
	query, err := db.Query("SELECT * FROM `MCap` WHERE 1")
	if err != nil {
		log.Println(err)
		context.JSON(400, gin.H{
			"message": "Can't get data",
		})
	}
	defer query.Close()

	var readings []Models.Data
	for query.Next() {
		var singleRead Models.Data
		err = query.Scan(&singleRead.Id, &singleRead.Temp, &singleRead.Hum)
		if err != nil {
			log.Println(err)
			context.JSON(400, gin.H{
				"message": "Can't get data",
			})
		}
		readings = append(readings, singleRead)
	}
	context.IndentedJSON(http.StatusOK, readings)
}

func AddData(context *gin.Context) {
	var newData Models.Data
	err := context.BindJSON(&newData)
	if err != nil {
		log.Println(err)
		return
	}

	db, err := Database.ConnectToDatabase()
	if err != nil {
		context.JSON(400, gin.H{
			"message": "Couldn't Connect To Database",
		})
	}
	defer db.Close()
	temp := float64(newData.Temp)
	hum := float64(newData.Hum)
	_, err = db.Exec("INSERT INTO `MCap` (`Id`, `Temp`, `Hum`) VALUES (NULL, ?, ?);", temp, hum)
	if err != nil {
		log.Println(err)
		context.JSON(400, gin.H{
			"message": "Invalid Data Format Entered",
		})
	}
	context.IndentedJSON(http.StatusCreated, newData)
}

func GetReadingsById(context *gin.Context) {
	id := context.Param("id")
	db, err := Database.ConnectToDatabase()
	if err != nil {
		context.JSON(400, gin.H{
			"message": "Couldn't Connect To Database",
		})
	}
	defer db.Close()
	// _, err = db.Exec("SELECT * FROM `Inventory` WHERE 1")
	query, err := db.Query("SELECT * FROM `MCap` WHERE Id = ?", id)
	if err != nil {
		log.Println(err)
		context.JSON(400, gin.H{
			"message": "Couldn't get data",
		})
	}
	defer query.Close()
	for query.Next() {
		var singleRead Models.Data
		err = query.Scan(&singleRead.Id, &singleRead.Temp, &singleRead.Hum)
		if err != nil {
			log.Println(err)
			context.JSON(400, gin.H{
				"message": "Couldn't get data",
			})
		}
		context.IndentedJSON(http.StatusOK, singleRead)
	}
}
