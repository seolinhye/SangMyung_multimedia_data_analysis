# SangMyung_multimedia_data_analysis

CFA Image의 ACPI를 통한 Image Demosaicking 성능 개선 
- Edge의 방향성의 변화도에 기반한 Adaptive Color Plane Interpolation를 사용
- Down sampling, Up sampling
- CFA의 특성상 보간하지 못하는 boundary 영역은 제거하여 계산



Simulation Results 

MOS 

![image](https://github.com/seolinhye/SangMyung_multimedia_data_analysis/assets/74964809/c727bd12-61ef-4e8c-a00f-a915ef86a273)

PSNR 1.88dB 개선

![image](https://github.com/seolinhye/SangMyung_multimedia_data_analysis/assets/74964809/3403b595-7205-4913-9a63-aa4df079b6d8)

SSIM 0.02 개선

![image](https://github.com/seolinhye/SangMyung_multimedia_data_analysis/assets/74964809/2fc46403-aeb1-46a4-a816-fd6f51423438)


