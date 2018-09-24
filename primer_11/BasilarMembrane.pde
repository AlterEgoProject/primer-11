// 基底膜のモデル
class BasilarMembrane{
  int n; // 共振モデルの数
  float FRAME_RATE; // フレームレート
  float K; // 抵抗係数
  float[] EIGEN_LIST; // 固有振動数の配列
  Resonance[] resonance; // 共振モデルの配列
  
  float before_wave; // 前のデータ
  
  // コンストラクタ(モデルの数,最小振動数,最大振動数,フレームレート,抵抗係数)
  BasilarMembrane(int num, float min_eigen, float max_eigen, float frame_rate, float k){
    n = num;
    FRAME_RATE = frame_rate;
    K = k;
    EIGEN_LIST = new float[n];
    resonance = new Resonance[n];
    for(int i=0; i<n; i++){
      float eigen = map(i, 0, n, min_eigen, max_eigen);
      EIGEN_LIST[i] = eigen;
      resonance[i] = new Resonance(eigen, frame_rate);
    }
    before_wave = 0; // 初期化
  }
  
  void oscillate(float[] wave){
    float wave_v;
    float external;
    for(int i=0; i < wave.length; i++){
      wave_v = (wave[i]-before_wave)*FRAME_RATE;
      for(int j=0; j < n; j++){
        float relative_v = resonance[j].v - wave_v;
        external = -K * pow(relative_v,2) * Math.signum(relative_v);
        resonance[j].move(external);
      }
      before_wave = wave[i];
    } 
  }
  
  float[] mechanical_energy(){
    float[] energy = new float[n]; // 力学的エネルギー
    for(int i=0; i < n; i++){
      energy[i] = resonance[i].energy();
    }
    return energy;
  }
}
