usage:
	echo "See Makefile"

vet:
	go vet ./...

updatedeps:
	go run github.com/tailscale/depaware --update tailscale.com/cmd/tailscaled
	go run github.com/tailscale/depaware --update tailscale.com/cmd/tailscale

depaware:
	go run github.com/tailscale/depaware --check tailscale.com/cmd/tailscaled
	go run github.com/tailscale/depaware --check tailscale.com/cmd/tailscale

buildwindows:
	GOOS=windows GOARCH=amd64 go install tailscale.com/cmd/tailscale tailscale.com/cmd/tailscaled

check: staticcheck vet depaware buildwindows

staticcheck:
	go run honnef.co/go/tools/cmd/staticcheck -- $$(go list ./... | grep -v tempfork)
