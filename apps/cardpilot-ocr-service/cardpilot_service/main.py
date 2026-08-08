import os

import uvicorn


def main():
    uvicorn.run(
        "cardpilot_service.api:app",
        host="0.0.0.0",
        port=int(os.getenv("PORT", "8080")),
        workers=1,
    )


if __name__ == "__main__":
    main()
