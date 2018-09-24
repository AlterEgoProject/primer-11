import ddf.minim.*;

// 共振モデル
int FRAME_RATE = 44100/1024;

float[] wave; // 波の配列
int wave_len = 1024;
int basal_len = 1000; // 球の数
float min_freq = 100; // 最小振動数
float max_freq = 4000; // 最大振動数
float k_resist =  pow(10,0); // 抵抗係数

float x_wave; // 描画用
float x_basal;  // 描画用

Minim minim;
AudioInput in;

BasilarMembrane bm;

void setup(){
  frameRate(FRAME_RATE);
  size(512, 400, P2D);
  minim = new Minim(this);
  in = minim.getLineIn();
  wave = new float[wave_len];
  x_wave = float(width)/(wave_len);
  x_basal = float(width)/(basal_len);
  bm = new BasilarMembrane(basal_len, min_freq, max_freq, 44100, k_resist);
}


void draw(){
  background(0);
  System.arraycopy(wave, 0, wave, 1, wave.length-1);
  
  for(int i = 0; i < in.bufferSize(); i++){
    wave[i] = in.mix.get(i);
  }
  
  stroke(255);
  // 入力値の描画
  for(int i=0; i < wave.length - 1; i++){ line(x_wave*i, 100 + wave[i]*100, x_wave*(i+1), 100 + wave[i+1]*100); }
  
  bm.oscillate(wave);

  // 球の描画
  //for(int i=0; i < basal_len; i++){ ellipse(x_basal*i+x_basal/2, 1000*bm.resonance[i].x + 300, 2, 2); }
  
  // 球の力学的エネルギー
  float[] energy = bm.mechanical_energy();
  for(int i=0; i < basal_len; i++){
    ellipse(x_basal*i+x_basal/2, -energy[i]/1000 + 300, 2, 2); 
  }

}
