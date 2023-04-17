// ols.js
import { line } from 'https://cdn.skypack.dev/d3-shape';
import { scaleLinear } from 'https://cdn.skypack.dev/d3-scale';
import { axisBottom, axisLeft } from 'https://cdn.skypack.dev/d3-axis';
import { select } from 'https://cdn.skypack.dev/d3-selection';


export function olsPlot(data, intercept, slope, show_residuals) {
  const margin = { top: 20, right: 20, bottom: 30, left: 50 };
  const width = 600 - margin.left - margin.right;
  const height = 400 - margin.top - margin.bottom;

  const x = scaleLinear()
    .domain([-4, 4])
    .range([0, width]);

  const y = scaleLinear()
    .domain([-10, 10])
    .range([height, 0]);

  const xAxis = axisBottom(x);
  const yAxis = axisLeft(y);

  const lineGenerator = line()
    .x(d => x(d.x))
    .y(d => y(d.y));

  const svg = select(DOM.svg(width + margin.left + margin.right, height + margin.top + margin.bottom))
    .attr("viewBox", `0 0 ${width + margin.left + margin.right} ${height + margin.top + margin.bottom}`)
    .style("font", "10px sans-serif");

  const g = svg.append("g")
    .attr("transform", `translate(${margin.left},${margin.top})`);

  g.append("g")
    .attr("transform", `translate(0,${height})`)
    .call(xAxis);

  g.append("g")
    .call(yAxis);

  g.selectAll("circle")
    .data(data)
    .enter().append("circle")
      .attr("cx", d => x(d.x))
      .attr("cy", d => y(d.y))
      .attr("r", 3)
      .attr("fill", "steelblue");

  const lineData = [
    { x: -4, y: -4 * slope + intercept },
    { x: 4, y: 4 * slope + intercept }
  ];

  g.append("path")
    .datum(lineData)
    .attr("d", lineGenerator)
    .attr("stroke", "blue")
    .attr("stroke-width", 1)
    .attr("fill", "none");

  if (show_residuals) {
    g.selectAll(".residual")
      .data(data)
      .enter().append("line")
        .attr("class", "residual")
        .attr("x1", d => x(d.x))
        .attr("y1", d => y(d.y))
        .attr("x2", d => x(d.x))
        .attr("y2", d => y(d.x * slope + intercept))
        .attr("stroke", "red")
        .attr("stroke-width", 0.5);
  }

  return svg.node();
}
