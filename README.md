# noisy-networks-measurements

Bayesian reconstruction of networks from noisy measurements, with examples.
The theory explaining these models is presented in ["Bayesian inference of network structure from unreliable data"](https://academic.oup.com/comnet/article/8/6/cnaa046/6161493), by [J.-G. Young](http://jgyoung.ca), [G. T. Cantwell](https://www.george-cantwell.com/) and [M.E.J. Newman](http://www-personal.umich.edu/~mejn/).
Here we provide several examples of models coded in `Stan`, as well as [a tutorial](tutorial/tutorial.ipynb) reproducing one of the case study of the paper.


![](repoimg.png)


## Dependencies

The only necessary dependency is `stan`. 
The framework will work with any [stan interface](https://mc-stan.org/users/interfaces/index.html).

[Our tutorial](tutorial/tutorial.ipynb) uses the python interface.
To install `pystan`, simply run:

    pip install pystan


## List of models

We provide code for a several standard models, as well as extensible templates for models not covered by our library of models.

* [Examples](examples/): Standard models.
* [Templates](templates/): Model templates, that can be used to implement custom models without writing boilerplate code. 

## Paper

If you use this code, please consider citing:

"[*Bayesian inference of network structure from unreliable data*](https://academic.oup.com/comnet/article/8/6/cnaa046/6161493)"<br/>
[J.-G. Young](http://jgyoung.ca), [G. T. Cantwell](https://www.george-cantwell.com/) and [M.E.J. Newman](http://www-personal.umich.edu/~mejn/)<br/>
J. Complex Netw. **8**, cnaa046 (2021) <br/>

## Author information

Code by [Jean-Gabriel Young](https://www.jgyoung.ca). Don't hesitate to get in touch at <jean-gabriel.young@uvm.edu>, or via the [issues](https://github.com/jg-you/noisy-networks-measurements/issues)!
