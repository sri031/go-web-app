FROM golang:1.22.5 AS build

WORKDIR /app

COPY go.mod /app

RUN go mod download

COPY . . 

RUN go build -o main 

#Final Distroless Image. 

FROM gcr.io/distroless/base

COPY --from=build /app/main .

COPY --from=build /app/static ./static

EXPOSE 8080

CMD [ "./main" ]




