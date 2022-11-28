/*░░░░░░░░░░░░░░░░░░░░░░ Galaxy Parameters ░░░░░░░░░░░░░░░░░░░░░░
N-body sim engine with Plummer potential and leap-frogging algo*/
blur_factor = 5.0;              // star blur unit-less        
dt = 10e+7                      // timestep in years           
g_scale_factor = 10e+0;         // gravity constant scale
size = 20000;                   // light years    
velocity_scl = 10e-12;
plot_scale = 0.01;              // zoom factor (if 1: 1px=1ly)
plummer_bulge = 1000;           // light years          
star_color = [
    '#f5dedc', 
    '#c9ffdd',                      
    '#c2dcff', 
    '#c2fffe', 
    '#171006'];
star_mass_max = 7;              // max sun masses
star_mass_min = .1;             // min sun masses
star_scale_factor = 1;          // unit-less
time_delay_ms = 0;              // milliseconds     
N = 100;                        // number of stars          
T = 10e+30;                     // total sim epoch in years        
const   m_sun = 1.988e+30,
        G = 6.67430e-11,
        ly = 9.46e+15,
        yr = 31.536e+6;
//░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
const[D,M,F]=[document,Math,Math.floor];//░░░░░ github.com/B0-B ░░
[w,h]=[window.innerWidth,window.innerHeight];C=[F(w/2),F(h/2)];cv=
D.createElement('canvas');X=cv.getContext('2d');D.body.appendChild
(cv);X.canvas.width=w;X.canvas.height=h;D.body.style.background=
'#04050d';function draw(x,y,s,c){X.fillStyle=c;X.beginPath();X.arc
(F(x+C[0]),F(y+C[1]),s*star_scale_factor,0,2*M.PI);X.fill();
X.shadowBlur=s*blur_factor;X.shadowColor=c;X.beginPath();X.arc(F(x
+C[0]),F(y+C[1]),s*star_scale_factor,0,2*M.PI);X.fill()}function 
dist(v,w){return[w[0]-v[0],w[1]-v[1]]}function dot(v,w){return v[0]
*w[0]+v[1]*w[1]}function mag(v){return dot(v,v)**.5}function a_plum
(v,w,m,a){r=dist(v,w);c=g_scale_factor*G*m/((dot(r,r)+a**2)**(1.5))
return[c*r[0],c*r[1]]}function v0(){for(s in S){r=S[s].slice(1,3);d 
=mag(r);m=0;for(n in S){sv=S[n].slice(1,3);if(mag(sv)<d){m+=S[n][0]
}}kep=G*m/(d**.5)*velocity_scl*m_sun;S[s][3]=-kep/d*r[1];S[s][4]=
kep/d*r[0]}}function u(){return M.random()}function bm(){x=u();A=M.
sqrt(-2*M.log(u()));return[A*M.cos(2*M.PI*x),A*M.sin(2*M.PI*x)]}
function star(){const[x,y]=bm();m=u()*(star_mass_max-star_mass_min)
+star_mass_min;col=star_color[F(u()*5)];return[m,x*size*ly,y*size*
ly,0,0,col]}S={};function scatter(){for(i=0;i<N;i++){S[i]=star()}}
async function plot(){for(s in S){draw(F(plot_scale*S[s][1]/ly),F(
plot_scale*S[s][2]/ly),S[s][0],S[s][5])}}async function lf(){t=0;
_dt=dt*yr;while(t<T){X.clearRect(0,0,cv.width,cv.height);plot();for
(p1 in S){a=[0,0];for(p2 in S){if(p2==p1){continue};f=a_plum(S[p1].
slice(1,3),S[p2].slice(1,3),S[p2][0]*m_sun,plummer_bulge*ly);a[0]=a
[0]+f[0];a[1]=a[1]+f[1]}const[dvx,dvy]=[a[0]*_dt*.5,a[1]*_dt*.5]
v_m_x=S[p1][3]+dvx;v_m_y=S[p1][4]+dvy;S[p1][1]=S[p1][1]+v_m_x*_dt;S
[p1][2]=S[p1][2]+v_m_y*_dt;S[p1][3]=v_m_x+dvx;S[p1][4]=v_m_y+dvy}
await new Promise(r=>setTimeout(r,time_delay_ms));t+=dt}}scatter();
v0();lf();