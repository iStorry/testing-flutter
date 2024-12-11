# Setup

```bash
dart pub global activate openapi_generator_cli
```

# Generate

```bash
openapi-generator-cli generate -i https://petstore3.swagger.io/api/v3/openapi.json -g dart -o lib/api
```
