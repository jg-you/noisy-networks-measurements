#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Python functions to interact with the stan models.

Author:
Jean-Gabriel Young <jean.gabriel.young@gmail.com>
"""
import numpy as np
import pickle
import pystan
import os

abs_path = os.path.dirname(os.path.abspath(__file__))


def compile_stan_model(model_file, force=False):
    """Autocompile Stan model."""
    model_name = os.path.splitext(model_file)[0]
    source_path = os.path.join(abs_path, model_name + '.stan')
    target_path = os.path.join(abs_path, model_name + '.bin')

    if os.path.exists(target_path):
        # Test whether the model has changed and only compile if it did
        with open(target_path, 'rb') as f:
            current_model = pickle.load(f)
        with open(source_path, 'r') as f:
            file_content = "".join([line for line in f])
        if file_content != current_model.model_code or force:
            print(target_path, "[Compiling]", ["", "[Forced]"][force])
            model = pystan.StanModel(source_path, model_name=model_name)
            with open(target_path, 'wb') as f:
                pickle.dump(model, f)
        else:
            print(target_path, "[Skipping --- already compiled]")
    else:
        # If model binary does not exist, compile it
        print(target_path, "[Compiling]")
        model = pystan.StanModel(source_path, model_name=model_name)
        with open(target_path, 'wb') as f:
            pickle.dump(model, f)


if __name__ == '__main__':
    print("Compiling models with pystan version", pystan.__version__)
    for m in os.listdir("examples"):
        if os.path.splitext(m)[1] == ".stan":
            compile_stan_model(m, force=False)
