package main

import (
	"encoding/json"
	"net/http"
)

type Response struct {
	Status       string `json:"status"`
	Message      string `json:"message"`
	Architecture string `json:"architecture"`
}

func healthHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(Response{
		Status:       "success",
		Message:      "Hello from container-craft Go microservice!",
		Architecture: "modular",
	})
}

func main() {
	http.HandleFunc("/", healthHandler)
	http.ListenAndServe(":8080", nil)
}