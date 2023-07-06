<script lang="ts">
    import { onMount } from "svelte";
    import { scaleLinear, scaleOrdinal } from "d3-scale";
    import { zoom, zoomIdentity } from "d3-zoom";
    import { schemeCategory10 } from "d3-scale-chromatic";
    import { select, selectAll, pointer } from "d3-selection";
    import { drag } from "d3-drag";
    import {
      forceSimulation,
      forceLink,
      forceManyBody,
      forceCenter,
      forceCollide,
    } from "d3-force";

var w = 500;
var h = 300;
var dataset = {
    nodes:[
            {name:"Adam"},
            {name:"Bob"},
            {name:"Carrie"},
            {name:"Donovan"},
            {name:"Edward"},
            {name:"Felicity"},
            {name:"George"},
            {name:"Hannah"},
            {name:"Iris"},
            {name:"Jerry"}
    ],
    edges:[
            {source: 0, target: 1},
            {source: 0, target: 2},
            {source: 0, target: 3},
            {source: 0, target: 4},
            {source: 1, target: 5},
            {source: 2, target: 5},
            {source: 2, target: 5},
            {source: 3, target: 4},
            {source: 5, target: 8},
            {source: 5, target: 9},
            {source: 6, target: 7},
            {source: 7, target: 8},
            {source: 8, target: 9},

    ]
};
var force = d3.layout.force()
                        .nodes(dataset.nodes)
                        .links(dataset.edges)
                        .size([w, h])
                        .linkDistance([100])
                        .charge([-150])
                        .start();

var colors = d3.scale.category10();
var svg = d3.select("body")
                .append("svg")
                .attr("width", w)
                .attr("height", h);
var edges = svg.selectAll("line")
                .data(dataset.edges)
                .enter()
                .append("line")
                .style("stroke", "#ccc")
                .style("stroke-width", 1);
var nodes = svg.selectAll("circle")
                .data(dataset.nodes)
                .enter()
                .append("circle")
                .attr("r", 10)
                .style("fill", function(d, i){
                    return colors(i);
                })
                .call(force.drag);
    
var label = svg.selectAll(".mytext")
                .data(dataset.nodes)
                .enter()
                .append("text")
                .text(function (d) { return d.name; })
                .style("text-anchor", "middle")
                .style("fill", "#555")
                .style("font-family", "Arial")
                .style("font-size", 12);

 

force.on("tick", function(){
    edges.attr("x1", function(d){ return d.source.x; })
         .attr("y1", function(d){ return d.source.y; })
         .attr("x2", function(d){ return d.target.x; })
         .attr("y2", function(d){ return d.target.y; });
    nodes.attr("cx", function(d){ return d.x; })
         .attr("cy", function(d){ return d.y; });
    label.attr("x", function(d){ return d.x; })
         .attr("y", function (d) {return d.y - 10; });

    
});
</script>