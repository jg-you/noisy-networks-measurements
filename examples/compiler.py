#!/usr/bin/env python3
"""
Python functions to interact with the Stan models.

Author:
Jean-Gabriel Young <jean.gabriel.young@gmail.com>
"""
from pathlib import Path

from cmdstanpy import CmdStanModel

abs_path = Path(__file__).parent.resolve()


def compile_stan_model(model_file: str | Path, force: bool = False) -> CmdStanModel:
    """Compile a Stan model using CmdStanPy.

    Args:
        model_file: Name or path of the .stan file
        force: If True, recompile even if binary exists

    Returns:
        Compiled CmdStanModel ready for sampling
    """
    model_path = Path(model_file)
    if not model_path.is_absolute():
        model_path = abs_path / model_path

    # Ensure .stan extension
    if model_path.suffix != ".stan":
        model_path = model_path.with_suffix(".stan")

    print(f"{model_path} [{'Forcing recompile' if force else 'Compiling'}]")
    model = CmdStanModel(stan_file=model_path, force_compile=force)

    return model


if __name__ == "__main__":
    import cmdstanpy

    print(f"Compiling models with cmdstanpy version {cmdstanpy.__version__}")
    for stan_file in abs_path.glob("*.stan"):
        compile_stan_model(stan_file, force=False)
