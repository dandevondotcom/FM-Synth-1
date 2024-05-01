/*A FM synth to learn GUI and synth concepts in SuperCollider */

//start engines
s.boot;
s.freeAll;
s.scope;

//FM1 synth definition
(
SynthDef.new(\fm1,{
	arg bus = 0, freq = 400, carPartial = 1, modPartial = 1,
	index = 3, mul = 0.05;
	// index values usually fall between 0 and 24
	// carPartial :: modPartial => car/mod ration
	var mod, car;
	mod = SinOsc.ar(freq * modPartial, 0, freq * index * LFNoise0.kr(5.reciprocal).abs);
	car = SinOsc.ar((freq * carPartial) + mod, 0, mul);
	Out.ar(bus,car);
}).add;
)

(
Pbind(
	\instrument, \fm1,
	\dur, Pwhite(0.05, 0.75),
	\freq, Pexprand(300, 800).trace,
	\atk, Pwhite(2.0, 3.0),
	\rel, Pwhite(0.005, 0.980),
	\amp, Pexprand(0.01, 0.8),
	\pan, Pwhite(-0.8, 0.8)
).play;
)

(
w= Window("decoration",Rect(200,200,500,200));
f = FreqScopeView(w, w.view.bounds);
w.view.decorator= FlowLayout(w.view.bounds, 10@10, 20@20);
k= Array.fill(4,{Knob(w.view,100@150).background_(Color.clear)});
w.front;
)


{arg x; tan (x**2)}.plotGraph(100,-pi,pi); // graph out of a function