import pickle

import driver

Result = driver.Result
plot_results = driver.plot_results

with open("results.pkl", "rb") as fp:
    results = pickle.load(fp)

plot_results(results)
