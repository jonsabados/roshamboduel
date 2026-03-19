package main

import (
	"net/http"
	"os"

	"github.com/jonsabados/roshamboduel/cmd"
	"github.com/rs/zerolog"
	"github.com/rs/zerolog/log"
)

func main() {
	zerolog.TimeFieldFormat = zerolog.TimeFormatUnixMs
	log.Logger = zerolog.New(os.Stdout).With().Timestamp().Logger()

	handler := cmd.CreateAPI()

	addr := ":8080"
	log.Info().Str("addr", addr).Msg("starting server")
	if err := http.ListenAndServe(addr, handler); err != nil {
		log.Fatal().Err(err).Msg("server failed")
	}
}