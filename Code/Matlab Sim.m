L1= link([90 0 45 0 0], 'standard')
L1=link([90 0 45 0], 'standard')
L2=link([0 12.065 30 0], 'standard')
L3=link([0 12.065 30 0], 'standard')
L4=link([-90 12.249 -45 0], 'standard')
L5=link([0 0 30 0], 'standard')
L6=link([0 0 0 0], 'standard')
r = robot({L1 L2 L3 L4 L5 L6})
