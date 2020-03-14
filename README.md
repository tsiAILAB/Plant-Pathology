# Plant-Pathology

Develop a CNN(Convolutional neural network) model to identify plant diseases using transfer learning strategy(VGG16). Optimize the model using intel OpenVino Toolkit to gernerate BIN, IR and MAPPING files. later, inference the optimized model using Intel OpenVino inferencing engine in local work station as well as in intel dev cloud edge. Inferencing is tested in several EDGE Nodes,
https://devcloud.intel.com/edge/resource_docs/selecting_targets/edge-nodes

a. TensorFlow Model to detect 4 diseases(Early Blight, Late Blight, Leaf Curl, Leaf Mold) of Tomato as well as healthy leaf
*please check the file "" to generate the TensorFlow Model
b. TensorFlow Model to detect 2 diseases of Potato(Early Blight and Late Blight) as well as healthy leaf
*please check the file "" to generate the TensorFlow Model
c. TensorFlow Model to detect 3 diseases of Maize(Common Rust, Gray Leaf Spot and Northern Leaf Blight) as well as helathy leaf
*please check the file "" to generate the TensorFlow Model

Please start reading in the folowing order to understand the project and execution:
1. Readme_intoduction_General Instructions.docx
(Problem Statement, Work scope and several defination like OpenVino Toolkit, Optimization and Inferencing)
2. Readme_1_Model_Development_LocalWorkStation_or_Colab.docx
(How to ready your workstation for OS, Tensorflow to develop model in your PC or in COLAB)
3. Readme_2_Model_Optimization_Inferencing_LocalworkStation(OpenVino, 2019 R3.1, Build date_23 Oct 2019).docx
(How to optimize and inference using OpenVino in user's workstation)
4. Readme_3_Model_Optimization_Inferencing_intel_dev_cloud.docx
(How to optimize and inference using OpenVino in intel dev cloud)
5. Readme_4_Model_Inferencing_intel_dev_cloud_edge_computing.docx
(How to optimize and inference using OpenVino in intel dev cloud edge to verify reference implementation for selective platforms)

For any query, please contact
MD fakrul Islam
fakrul.islam@tsi.com.bd
