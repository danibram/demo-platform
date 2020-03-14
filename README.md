# Demo Platform

## Development

1. Clone this repo
2. Run `make init`
3. Add to your hosts `access.alliron.local` and `access.alliron.local`
4. Run `make dev`

### Note: Use postman collection

1. Import `platform-Demo.postman_collection.json`
2. Add variables
   booking-api -> booking.alliron.local
   access-control-api -> access.alliron.local
3. BookingId is automatically populated from the booking request
