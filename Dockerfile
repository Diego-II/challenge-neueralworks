FROM --platform=linux/x86_64 public.ecr.aws/lambda/python:3.10

ENV PYTHONUNBUFFERED 1

RUN python -m pip install --upgrade pip\
    && pip install "poetry==1.4.1"

RUN poetry config virtualenvs.create false
COPY poetry.lock ./
COPY pyproject.toml ./

RUN poetry install --no-interaction --no-ansi --no-root --no-dev


COPY ./challenge_neueralworks ./challenge_neueralworks
COPY ./models /models

CMD ["challenge_neueralworks.src.lambda_handler.lambda_handler"]