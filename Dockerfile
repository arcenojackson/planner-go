FROM golang:1.22.4-alpine as build

WORKDIR /app

COPY go.mod go.sum ./

RUN go mod download && go mod verify

COPY . .

RUN go build -o /bin/journey ./cmd/journey/journey.go

FROM scratch

WORKDIR /app

COPY --from=build /bin/journey .

EXPOSE 8080

ENTRYPOINT [ "./journey" ]
