package Routes

import (
	"github.com/gin-gonic/gin"
	"GoServer/Controllers"
)

func RouteConfig() {
	router := gin.Default()
	router.GET("/Readings", Controllers.GetAllData)
	router.GET("/Readings/:id", Controllers.GetReadingsById)
	router.POST("/Readings", Controllers.AddData)
	router.Run(":9090")
}
