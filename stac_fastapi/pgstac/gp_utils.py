""" Geoplatform specific utils and customization"""
import os
from fastapi import Depends, HTTPException, status, security


""""
Basic HTTP Authentication
"""
API_USERNAME = os.getenv('API_USERNAME')
API_PASSWORD = os.getenv('API_PASSWORD')

http_basic = security.HTTPBasic()

def must_be_authenticated(credentials: security. HTTPBasicCredentials = Depends(http_basic)):
    """
    Following pattern here: https://github.com/stac-utils/stac-fastapi/pull/295
    More info on FastAPI's basic auth: https://fastapi.tiangolo.com/advanced/security/http-basic-auth/?h=httpbasiccredentials#simple-http-basic-auth
    """
    if credentials.username == API_USERNAME and credentials.password == API_PASSWORD:
        return True
    raise HTTPException(
        status_code=status.HTTP_401_UNAUTHORIZED,
        detail=f"Authentication failed for {credentials.username}",
        headers={"WWW-Authenticate": "Basic"},
    )

route_dependencies=[
        # Only Authenticated Users can edit our data...
        (
            [
                {"path": "/collections", "method": "POST"},
                {"path": "/collections", "method": "PUT"},
                {"path": "/collections/{collectionId}", "method": "DELETE"},
                {"path": "/collections/{collectionId}/items", "method": "POST"},
                {"path": "/collections/{collectionId}/items/{itemId}", "method": "PUT"},
                {"path": "/collections/{collectionId}/items/{itemId}", "method": "DELETE"},
                {"path": "/collections/{collection_id}/bulk_items", "method": "POST"}
            ],
            [Depends(must_be_authenticated)]
        ),
    ]