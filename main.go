package main

// ./main.go
import "github.com/kataras/iris"

func main() {
	iris.Get("/hi", hi)
	// http://localhost:5700/api/user/42
	// Method: "GET"
	iris.Get("/api/user/:id", func(ctx *iris.Context) {

		// take the :id from the path, parse to integer
		// and set it to the new userID local variable.
		userID, _ := ctx.ParamInt("id")

		// userRepo, imaginary database service <- your only job.
		user := struct {
			ID   int
			Name string
		}{ID: userID, Name: "tony"}

		// send back a response to the client,
		// .JSON: content type as application/json; charset="utf-8"
		// iris.StatusOK: with 200 http status code.
		//
		// send user as it is or make use of any json valid golang type,
		// like the iris.Map{"username" : user.Username}.
		ctx.JSON(iris.StatusOK, user)

	})
	iris.Listen(":8080")
}

func hi(ctx *iris.Context) {
	ctx.Render("hi.html", struct{ Name string }{Name: "iris"})
}
