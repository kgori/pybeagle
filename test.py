import pybeagle
import numpy as np
import logging
def set_logger():
    logger = logging.getLogger(__name__)
    logger.setLevel(logging.DEBUG)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
    # create console handler with a higher log level
    console = logging.StreamHandler()
    console.setLevel(logging.INFO)
    console.setFormatter(formatter)
    # add the handlers to the logger
    logger.addHandler(console)
    return logger
logger = set_logger()

DOUBLE = np.double
INT = np.intc

print pybeagle.get_citation()


resources = pybeagle.get_resource_list()
for r in resources:
    print r


def prep(l, astype):
    return np.ascontiguousarray(np.array(l).flatten(), dtype=astype)


a = "GGAAAGGGAATAAGACAAAGCTATACATAGAAAGTTAAGGAGGAGAAGGAGACGTGGAGTAGCGAAGGTAGATGACCTTTCGAAGGAGCACATGTAGTGATCGGGACGCTCGAGGCGTCACGTGGATGAGAGGGTAGTCGACATCGACCAGTTCCTACAACCTAGACACATTGAGACGGCTGACACAGTCCAACAAGAGG";
b = "CGAAAGGTAAGCAGACAAAGCTATACATATAAAGTTAAGGAGGAGAACTCGATGTGGCTTAGAGAAGGTGCATCACGTTTGCCCGGGGCACATGTTGTGATTCGCACCCTCGAGTCGTCTGGTGGATGAGAGGGAAGTCGAAACGGACTAATTTCTCCAACATAGAAACATAGACAATGCTGACAGAGCCGAACAACAGG";
c = "GTACGGGCTCCAACATGAAGTTATACATATAAGGTTAAGGACTGGAACCCGGTTTGGAGTAGATAAGGTAGAAGAAAGTCGCAAGGAGCGTACATGGAGATGGGGAAGCTGTAGCCCTAAGGGGGAGGAGCGGGCGTTCGAGATGGCCAAGGGGCTCCACGATAGATAAACCGATAAGGCTGATTAAGTCAGACACGAGC";
d = "CCGGTGGGAAGAACTTAAAGTTATAGACCTAGAGGGACGGAATCGAAGTGGCCCGACAATAGAGGACGGGGCGTAATGCCGCGCGACGAGTTTCAGCGGATGGGTGAGTTAAAGCCCGACACCGAAATCTCGGGAAACCTCGAGCGCGAAAGGGATCCATCCTAGAAGGGTAGAGAAGGCTGGATGAGAACAATCACAAC";
e = "AGGAAGGCGAGAACCTTAAGAAATAGAAATAAAGTTAAGCGCTGGAGCCTGGATGCAAATATAGGACTTGGAGTCAACGTACAGCAAGAGCACTGTGGGGTCGGGGCGTTCTCGACGTACAGGGAATCAGAGGGCAGTCCACACGACTGGGAAGACCCGATAGAGAACGATGGACTAGGCGGAATAAGAAAGATCACACT";

converter = {
    'A':np.array([1.0, 0.0, 0.0, 0.0]) ,
    'C':np.array([0.0, 1.0, 0.0, 0.0]) ,
    'G':np.array([0.0, 0.0, 1.0, 0.0]) ,
    'T':np.array([0.0, 0.0, 0.0, 1.0]) ,
}

partials_a = prep([converter.get(x, np.array([1.0, 1.0, 1.0, 1.0])) for x in a], astype=DOUBLE)
partials_b = prep([converter.get(x, np.array([1.0, 1.0, 1.0, 1.0])) for x in b], astype=DOUBLE)
partials_c = prep([converter.get(x, np.array([1.0, 1.0, 1.0, 1.0])) for x in c], astype=DOUBLE)
partials_d = prep([converter.get(x, np.array([1.0, 1.0, 1.0, 1.0])) for x in d], astype=DOUBLE)
partials_e = prep([converter.get(x, np.array([1.0, 1.0, 1.0, 1.0])) for x in e], astype=DOUBLE)


logger.info("Creating BeagleInstanceDetails")
bi = pybeagle.BeagleInstanceDetails()
logger.info("Initialising BeagleInstanceDetails")
pybeagle.create_instance(5,8,0,4,200,1,21,4,0,1,0,0,bi)
logger.info("Resource number: {}".format(bi.resourceNumber))
logger.info("Resource name: {}".format(bi.resourceName))
logger.info("Impl name: {}".format(bi.implName))
logger.info("Impl description: {}".format(bi.implDescription))
logger.info("Flags: {}".format(bi.flags))
i = bi.resourceNumber

BEAGLE_OP_NONE = pybeagle.OpCodes.OP_NONE

logger.info("Setting tip partials")
assert pybeagle.set_tip_partials(i, 0, partials_a) == 0, 'Error'
assert pybeagle.set_tip_partials(i, 1, partials_b) == 0, 'Error'
assert pybeagle.set_tip_partials(i, 2, partials_c) == 0, 'Error'
assert pybeagle.set_tip_partials(i, 3, partials_d) == 0, 'Error'
assert pybeagle.set_tip_partials(i, 4, partials_e) == 0, 'Error'

logger.info("Setting pattern weights")
patt_weights = prep([1.0 for _ in a], astype=DOUBLE)
assert pybeagle.set_pattern_weights(i, patt_weights) == 0, 'Error'

logger.info("Setting frequencies")
freq = prep([0.3591448418303572,0.17990592923287677,0.30088911954606995,0.1600601093906961], astype=DOUBLE)
assert pybeagle.set_state_frequencies(i, 0, freq) == 0, 'Error'

logger.info("Setting cat weights and rates")
cat_weights = prep([0.25, 0.25, 0.25, 0.25], astype=DOUBLE)
cat_rates = prep([0.2932747160378261, 0.6550136762040464, 1.0699896621148572, 1.9817219456432702], astype=DOUBLE)
assert pybeagle.set_category_weights(i, 0, cat_weights) == 0, 'Error'
assert pybeagle.set_category_rates(i, cat_rates) == 0, 'Error'

logger.info("Setting eigenvectors and values")
evec = prep([[-0.203, -0.001,  0.673,  0.5],
                            [ 0.934,  0.003, -0.003,  0.5],
                            [-0.205, -0.47 , -0.523,  0.5],
                            [-0.209,  0.883, -0.523,  0.5]], astype=DOUBLE)

ivec = prep([[-0.381,  0.878, -0.322, -0.175],
                            [-0.002,  0.003, -0.74 ,  0.739],
                            [0.837, -0.002, -0.545, -0.29],
                            [0.718,  0.36 ,  0.602,  0.32]], astype=DOUBLE)

evals = prep([-2.549, -1.34 , -0.664,  0.], astype=DOUBLE)

assert pybeagle.set_eigen_decomposition(i, 0, evec, ivec, evals) == 0, 'Error'


edge_index = prep([0, 1, 2, 3, 4, 5, 6], astype=INT)
edge_index_d1 = prep(edge_index + 7, astype=INT)
edge_index_d2 = prep(edge_index + 14, astype=INT)
edge_length = prep([0.0809704656376, 0.256065681235, 0.275250715264, 0.766145237663, 0.580351497411, 0.34826964074, 0.69649788029], astype=DOUBLE)

logger.info("Updating all transition matrices")
assert pybeagle.update_transition_matrices(i,
                                           0,
                                           edge_index,
                                           edge_index_d1,
                                           edge_index_d2,
                                           edge_length,
                                           7) == 0, 'Error'

logger.info("Updating partials")
operations = prep([5, BEAGLE_OP_NONE, BEAGLE_OP_NONE, 0, 0, 1, 1,
                   6, BEAGLE_OP_NONE, BEAGLE_OP_NONE, 5, 5, 2, 2,
                   7, BEAGLE_OP_NONE, BEAGLE_OP_NONE, 3, 3, 4, 4], astype=INT)
assert pybeagle.update_partials(i, operations, 3, BEAGLE_OP_NONE) == 0, 'Error'

parent_index = prep([7], INT)
child_index = prep([6], INT)
edge_p_index = prep([6], INT)
edge_dp_index = prep([13], INT)
edge_d2p_index = prep([20], INT)
cat_index = prep([0], INT)
freq_index = prep([0], INT)
scale_index = prep([BEAGLE_OP_NONE], INT)
lnl = prep([0], DOUBLE)
dlnl = prep([0], DOUBLE)
d2lnl = prep([0], DOUBLE)

logger.info("Calculating edge log-likelihood")
pybeagle.calculate_edge_log_likelihoods(
            i,
            parent_index,
            child_index,
            edge_p_index,
            edge_dp_index,
            edge_d2p_index,
            cat_index,
            freq_index,
            scale_index,
            1,
            lnl,
            dlnl,
            d2lnl
    )
logger.info("Likelihood result: lnl={} dlnl/dt={} d2lnl/dt2={}".format(lnl[0], dlnl[0], d2lnl[0]))

out_partials = prep(np.zeros(partials_a.size), DOUBLE)
pybeagle.get_partials(i, 7, -1, out_partials)

out_site_lnl = prep(np.zeros(len(a)), DOUBLE)
out_site_dlnl = prep(np.zeros(len(a)), DOUBLE)
out_site_d2lnl = prep(np.zeros(len(a)), DOUBLE)
pybeagle.get_site_log_likelihoods(i, out_site_lnl)
pybeagle.get_site_derivatives(i, out_site_dlnl, out_site_d2lnl)

def adj_br(val):
    assert pybeagle.update_transition_matrices(i, 0, edge_p_index, edge_dp_index, edge_d2p_index, prep(val, DOUBLE), 1) == 0, 'error'
    pybeagle.calculate_edge_log_likelihoods(
                i,
                parent_index,
                child_index,
                edge_p_index,
                edge_dp_index,
                edge_d2p_index,
                cat_index,
                freq_index,
                scale_index,
                1,
                lnl,
                dlnl,
                d2lnl
        )
# y = []
# for val in np.linspace(0, 2, 201):
#     adj_br(val)
#     logger.debug('{} {} {} {}'.format(val, lnl[0], dlnl[0], d2lnl[0]))
#     y.append(lnl[0])
# print y
###
# NEWTON RAPHSON
###
EPS = 0.00001
MAXIT = 10
def optimise_edge(i, edges, pari, chi, edgepi, edgedpi, edged2pi, cati, frqi, sci, lnl, dlnl, d2lnl):
    assert pybeagle.calculate_edge_log_likelihoods(i, parent_index, child_index, edge_p_index, edge_dp_index, edge_d2p_index, cat_index, freq_index, scale_index, 1, lnl, dlnl, d2lnl)==0, 'error'
    return nr(i, edges, pari, chi, edgepi, edgedpi, edged2pi, cati, frqi, sci, lnl, dlnl, d2lnl, computations=1, updates=0)

def nr(i, edges, pari, chi, edgepi, edgedpi, edged2pi, cati, frqi, sci, lnl, dlnl, d2lnl, computations=0, updates=0):
    """
    Newton-Raphson routine to optimise a single branch length.
    Assumes that partials are valid at head and tail nodes,
    and the transition matrix for the branch is up to date.
    """
    #pybeagle.calculate_edge_log_likelihoods(i, parent_index, child_index, edge_p_index, edge_dp_index, edge_d2p_index, cat_index, freq_index, scale_index, 1, lnl, dlnl, d2lnl)
    #computations += 1
    step = -np.sign(d2lnl)*(dlnl / d2lnl)
    orig_lnl = 0+lnl
    it = 0
    edges[edgepi] -= step
    while it < MAXIT:
        logger.debug("Edge = {}, lnl = {}, dlnl = {}, d2lnl = {}, step = {}".format(edges[edgepi], lnl, dlnl, d2lnl, step))
        assert pybeagle.update_transition_matrices(i, 0, edgepi, edgedpi, edged2pi, edges[edgepi], 1)==0, 'error'
        assert pybeagle.calculate_edge_log_likelihoods(i, parent_index, child_index, edge_p_index, edge_dp_index, edge_d2p_index, cat_index, freq_index, scale_index, 1, lnl, dlnl, d2lnl)==0, 'error'
        computations += 1
        updates += 1
        if lnl > orig_lnl and edges[edgepi] > 0:
            break
        else:
            step *= 0.5
            edges[edgepi] += step
            it += 1
    if it >= MAXIT:
        logging.warn("MAXIT reached")
        return lnl, edges[edgepi], computations, updates
    if np.abs(lnl-orig_lnl) < EPS:
        return lnl, edges[edgepi], computations, updates
    else:
        return nr(i, edges, pari, chi, edgepi, edgedpi, edged2pi, cati, frqi, sci, lnl, dlnl, d2lnl, computations, updates)

#print optimise_edge(i, edge_length, parent_index, child_index, edge_p_index, edge_dp_index, edge_d2p_index, cat_index, freq_index, scale_index, lnl, dlnl, d2lnl)

# print out_site_lnl, out_site_lnl.sum()
# print out_site_dlnl, out_site_dlnl.sum()
# print out_site_d2lnl, out_site_d2lnl.sum()
