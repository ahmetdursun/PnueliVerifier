# Verifying Pnueli's Mutual Exclusion Algorithm 

In this repository, Pnueli's Mutual Exclusion Algorithm is modeled in Promela. SPIN is a model checker and it is used 
to verify the correctness of the given model.  


* [Promela Model and LTL Specs of Pnueli's Algorithm](/pnueliloop.pml)

### Mutual Exclusion

The property of mutual exclusion is formulated as the following LTL formula in Promela:
```sh
ltl p0	{[]!((y[0]==1 && (y[1]==0 || s!=0)) && (y[1]==1 && (y[0]==0 || s!=1)))}
```
Spin results show that this claim is not violated:

```sh
$ ./pan -a -N p0
pan: ltl formula p0

(Spin Version 6.4.7 -- 19 August 2017)
	+ Partial Order Reduction

Full statespace search for:
	never claim         	+ (p0)
	assertion violations	+ (if within scope of claim)
	acceptance   cycles 	+ (fairness disabled)
	invalid end states	- (disabled by never claim)

State-vector 60 byte, depth reached 826, errors: 0
      737 states, stored
     1400 states, matched
     2137 transitions (= stored+matched)
        1 atomic steps
hash conflicts:       183 (resolved)

Stats on memory usage (in Megabytes):
    0.062	equivalent memory usage for states (stored*(State-vector + overhead))
    0.284	actual memory usage for states
  128.000	memory used for hash table (-w24)
    0.534	memory used for DFS stack (-m10000)
  128.730	total actual memory usage
```

#### Absence of Unbounded Overtaking

Absence of unbounded overtaking is formulated as the following LTL formula:
```sh
ltl p1  {[]((y[0]==1 ) -> <>(y[0]==0))}

ltl p2  {[]((y[1]==1 ) -> <>(y[1]==0))}
```
Spin results show that these claims are not violated:
```sh
$ ./pan -a -N p1
pan: ltl formula p1

(Spin Version 6.4.7 -- 19 August 2017)
	+ Partial Order Reduction

Full statespace search for:
	never claim         	+ (p1)
	assertion violations	+ (if within scope of claim)
	acceptance   cycles 	+ (fairness disabled)
	invalid end states	- (disabled by never claim)

State-vector 60 byte, depth reached 826, errors: 0
     1035 states, stored (1333 visited)
     2635 states, matched
     3968 transitions (= visited+matched)
        1 atomic steps
hash conflicts:       218 (resolved)

Stats on memory usage (in Megabytes):
    0.087	equivalent memory usage for states (stored*(State-vector + overhead))
    0.284	actual memory usage for states
  128.000	memory used for hash table (-w24)
    0.534	memory used for DFS stack (-m10000)
  128.730	total actual memory usage
  
$ ./pan -a -N p2
pan: ltl formula p2

(Spin Version 6.4.7 -- 19 August 2017)
	+ Partial Order Reduction

Full statespace search for:
	never claim         	+ (p2)
	assertion violations	+ (if within scope of claim)
	acceptance   cycles 	+ (fairness disabled)
	invalid end states	- (disabled by never claim)

State-vector 60 byte, depth reached 826, errors: 0
     1032 states, stored (1327 visited)
     2638 states, matched
     3965 transitions (= visited+matched)
        1 atomic steps
hash conflicts:       207 (resolved)

Stats on memory usage (in Megabytes):
    0.087	equivalent memory usage for states (stored*(State-vector + overhead))
    0.284	actual memory usage for states
  128.000	memory used for hash table (-w24)
    0.534	memory used for DFS stack (-m10000)
  128.730	total actual memory usage
```

Therefore we can say that if a process wants to enter critical section it will eventually do that.

#### Entering Critical Section Infinitely Often

Following LTL formulas are used to check whether each process will occupy its critical section infinitely often or not.

```sh
ltl p3  {[]<>(y[0]==1)}

ltl p4  {[]<>(y[1]==1)}
```
Spin results show that these claims are not violated:
```sh
$ ./pan -a -N p3
pan: ltl formula p3
pan:1: acceptance cycle (at depth 11)
pan: wrote pnueliloop.pml.trail

(Spin Version 6.4.7 -- 19 August 2017)
Warning: Search not completed
	+ Partial Order Reduction

Full statespace search for:
	never claim         	+ (p3)
	assertion violations	+ (if within scope of claim)
	acceptance   cycles 	+ (fairness disabled)
	invalid end states	- (disabled by never claim)

State-vector 60 byte, depth reached 18, errors: 1
        9 states, stored
        0 states, matched
        9 transitions (= stored+matched)
        1 atomic steps
hash conflicts:         0 (resolved)

Stats on memory usage (in Megabytes):
    0.001	equivalent memory usage for states (stored*(State-vector + overhead))
    0.284	actual memory usage for states
  128.000	memory used for hash table (-w24)
    0.534	memory used for DFS stack (-m10000)
  128.730	total actual memory usage
  
$ ./pan -a -N p4
pan: ltl formula p4
pan:1: acceptance cycle (at depth 13)
pan: wrote pnueliloop.pml.trail

(Spin Version 6.4.7 -- 19 August 2017)
Warning: Search not completed
	+ Partial Order Reduction

Full statespace search for:
	never claim         	+ (p4)
	assertion violations	+ (if within scope of claim)
	acceptance   cycles 	+ (fairness disabled)
	invalid end states	- (disabled by never claim)

State-vector 60 byte, depth reached 20, errors: 1
       13 states, stored
        1 states, matched
       14 transitions (= stored+matched)
        1 atomic steps
hash conflicts:         0 (resolved)

Stats on memory usage (in Megabytes):
    0.001	equivalent memory usage for states (stored*(State-vector + overhead))
    0.284	actual memory usage for states
  128.000	memory used for hash table (-w24)
    0.534	memory used for DFS stack (-m10000)
  128.730	total actual memory usage

```