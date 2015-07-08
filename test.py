import pybeagle
import numpy as np
import logging

print pybeagle.get_citation()


resources = pybeagle.get_resource_list()
print resources[0]


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

partials_a = prep([converter.get(x, np.array([1.0, 1.0, 1.0, 1.0])) for x in a], astype=np.float64)
partials_b = prep([converter.get(x, np.array([1.0, 1.0, 1.0, 1.0])) for x in b], astype=np.float64)
partials_c = prep([converter.get(x, np.array([1.0, 1.0, 1.0, 1.0])) for x in c], astype=np.float64)
partials_d = prep([converter.get(x, np.array([1.0, 1.0, 1.0, 1.0])) for x in d], astype=np.float64)
partials_e = prep([converter.get(x, np.array([1.0, 1.0, 1.0, 1.0])) for x in e], astype=np.float64)

bi = pybeagle.BeagleInstance(5,8,0,4,200,1,21,4,0,0,0,1)
i = bi.instance
BEAGLE_OP_NONE = pybeagle.OpCodes.OP_NONE


assert pybeagle.set_tip_partials(i, 0, partials_a) == 0, 'Error'
assert pybeagle.set_tip_partials(i, 1, partials_b) == 0, 'Error'
assert pybeagle.set_tip_partials(i, 2, partials_c) == 0, 'Error'
assert pybeagle.set_tip_partials(i, 3, partials_d) == 0, 'Error'
assert pybeagle.set_tip_partials(i, 4, partials_e) == 0, 'Error'

patt_weights = prep([1.0 for _ in a], astype=np.float64)
assert pybeagle.set_pattern_weights(i, patt_weights) == 0, 'Error'

freq = prep([0.3591448418303572,0.17990592923287677,0.30088911954606995,0.1600601093906961], astype=np.float64)
assert pybeagle.set_state_frequencies(i, 0, freq) == 0, 'Error'

cat_weights = prep([0.25, 0.25, 0.25, 0.25], astype=np.float64)
cat_rates = prep([0.2932747160378261, 0.6550136762040464, 1.0699896621148572, 1.9817219456432702], astype=np.float64)
assert pybeagle.set_category_weights(i, 0, cat_weights) == 0, 'Error'
assert pybeagle.set_category_rates(i, cat_rates) == 0, 'Error'

evec = prep([[-0.203, -0.001,  0.673,  0.5],
                            [ 0.934,  0.003, -0.003,  0.5],
                            [-0.205, -0.47 , -0.523,  0.5],
                            [-0.209,  0.883, -0.523,  0.5]], astype=np.float64)

ivec = prep([[-0.381,  0.878, -0.322, -0.175],
                            [-0.002,  0.003, -0.74 ,  0.739],
                            [0.837, -0.002, -0.545, -0.29],
                            [0.718,  0.36 ,  0.602,  0.32]], astype=np.float64)

evals = prep([-2.549, -1.34 , -0.664,  0.], astype=np.float64)

assert pybeagle.set_eigen_decomposition(i, 0, evec, ivec, evals) == 0, 'Error'


edge_index = prep([0, 1, 2, 3, 4, 5, 6], astype=np.intc)
edge_index_d1 = prep(edge_index + len(edge_index), astype=np.intc)
edge_index_d2 = prep(edge_index + 2*len(edge_index), astype=np.intc)
edge_length = prep([0.0809704656376, 0.256065681235, 0.275250715264, 0.766145237663, 0.580351497411, 0.34826964074, 0.69649788029], astype=np.float64)

assert pybeagle.update_transition_matrices(i,
                                           0,
                                           edge_index,
                                           edge_index_d1,
                                           edge_index_d2,
                                           edge_length,
                                           7) == 0, 'Error'

operations = prep([5, BEAGLE_OP_NONE, BEAGLE_OP_NONE, 0, 0, 1, 1,
                   6, BEAGLE_OP_NONE, BEAGLE_OP_NONE, 5, 5, 2, 2,
                   7, BEAGLE_OP_NONE, BEAGLE_OP_NONE, 3, 3, 4, 4], astype=np.intc)
assert pybeagle.update_partials(i, operations, 3, BEAGLE_OP_NONE) == 0, 'Error'

parent_index = prep([7], np.intc)
child_index = prep([6], np.intc)
edge_p_index = prep([6], np.intc)
edge_dp_index = prep([13], np.intc)
edge_d2p_index = prep([20], np.intc)
cat_index = prep([0], np.intc)
freq_index = prep([0], np.intc)
scale_index = prep([BEAGLE_OP_NONE], np.intc)
lnl = prep([0], np.float64)
dlnl = prep([0], np.float64)
d2lnl = prep([0], np.float64)

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
print lnl, dlnl, d2lnl

out_partials = prep(np.zeros(partials_a.size), np.float64)
pybeagle.get_partials(i, 7, -1, out_partials)

out_site_lnl = prep(np.zeros(len(a)), np.float64)
out_site_dlnl = prep(np.zeros(len(a)), np.float64)
out_site_d2lnl = prep(np.zeros(len(a)), np.float64)
pybeagle.get_site_log_likelihoods(i, out_site_lnl)
pybeagle.get_site_derivatives(i, out_site_dlnl, out_site_d2lnl)
# print out_site_lnl, out_site_lnl.sum()
# print out_site_dlnl, out_site_dlnl.sum()
# print out_site_d2lnl, out_site_d2lnl.sum()
