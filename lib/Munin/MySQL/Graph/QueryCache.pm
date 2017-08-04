package Munin::MySQL::Graph::QueryCache;

use warnings;
use strict;

sub graphs { return {
    qcache => {
        config => {
            global_attrs => {
                title  => 'Query Cache',
                vlabel => 'Commands per ${graph_period}',
            },
            data_source_attrs => {
                 draw => 'LINE1',
            },
        },
        data_sources => [
            {name => 'Qcache_queries_in_cache', label => 'Queries in cache (K)',
                                                info  => 'The number of queries registered in the query cache.',
                                                cdef  => 'Qcache_queries_in_cache,1024,/',
                                                type  => 'GAUGE'},
            {name => 'Qcache_hits',             label => 'Cache hits',
                                                info  => 'The number of query cache hits.'},
            {name => 'Qcache_inserts',          label => 'Inserts',
                                                info  => 'The number of queries added to the query cache.'},
            {name => 'Qcache_not_cached',       label => 'Not cached',
                                                info  => 'The number of noncached queries (not cacheable, or not cached due to the query_cache_type setting).'},
            {name => 'Qcache_lowmem_prunes',    label => 'Low-memory prunes',
                                                info  => 'The number of queries that were deleted from the query cache because of low memory.'},
        ],
    },

    #---------------------------------------------------------------------

    qcache_mem => {
        config => {
            global_attrs => {
                title  => 'Query Cache Memory',
                vlabel => 'Bytes',
                args   => "--base 1024 --lower-limit 0",
            },
            data_source_attrs => {
                type => 'GAUGE',
            },
        },
        data_sources => [
            {name => 'query_cache_size',    label  => 'Cache size',
                                            info   => 'The amount of memory allocated for caching query results.',
                                            draw   => 'LINE1',
                                            colour => '000000'},
            {name => 'Qcache_used_memory',  label  => 'Used mem',
                                            info   => 'The amount of used memory for the query cache.',
                                            cdef   => 'query_cache_size,Qcache_free_memory,-',
                                            draw   => 'AREA',
                                            colour => '8d01ba'},
            {name => 'Qcache_free_memory',  label  => 'Free mem',
                                            info   => 'The amount of free memory for the query cache.',
                                            draw   => 'STACK',
                                            colour => '96e789'},
        ],
    },
}}

1;
