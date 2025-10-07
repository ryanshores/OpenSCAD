#!/usr/bin/env python3

import argparse
import os

from src.models.Part import Part
from src.utility import logs

logger = logs.Logger(__name__)

if __name__ == "__main__":
    try:
        parser = argparse.ArgumentParser(
            description="Generate specified export files from openscad files.")
        parser.add_argument(
            '--dry-run',
            action='store_true',
            help="If set, new versions will be created.")
        args = parser.parse_args()

        part = Part(os.getcwd(), args.dry_run)
        part.run()
    except Exception as e:
        logger.error("an error occurred: %s", e)
        exit(1)