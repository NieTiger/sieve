import pickle

import scripts.driver

Result = scripts.driver.Result
plot_results = scripts.driver.plot_results

with open("results.pkl", "rb") as fp:
    results = pickle.load(fp)

plot_results(results)
