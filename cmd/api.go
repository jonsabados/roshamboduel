package cmd

import (
	"net/http"
	"os"

	"github.com/jonsabados/roshamboduel/api"
	"github.com/rs/zerolog"
)

func CreateAPI() http.Handler {
	logLevel, err := zerolog.ParseLevel(os.Getenv("LOG_LEVEL"))
	if err != nil {
		logLevel = zerolog.InfoLevel
	}

	logger := zerolog.New(os.Stdout).
		Level(logLevel).
		With().
		Timestamp().
		Logger()

	cfg := api.Config{
		AllowedOrigin: os.Getenv("ALLOWED_ORIGIN"),
		Logger:        logger,
	}

	return api.NewRouter(cfg)
}