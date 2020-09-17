//
//  CreateFirstStepViewController.swift
//  VKVezdekod
//
//  Created by Ян Мелоян on 12.09.2020.
//

import CoreServices
import UIKit

class CreateFirstStepViewController: VKStackViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
    
    let picker = UIImagePickerController()
    
    var fieldList:[InputView] = []
    
    let coverView = CoverSelectionView()
    
    init(type:SelectType) {
        super.init(nibName: nil, bundle: nil)
        
        setupPicker()
        scrollView.contentInset.bottom = 60
        
        switch type {
        case .celevoi:
            navigationItem.title = "Целевой сбор"
        case .regular:
            navigationItem.title = "Регулярный сбор"
        }
        view.backgroundColor = .brandWhite
        
        stackView.spacing = 0
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins.top = 10
        
        stackView.addArrangedSubview(coverView)
        coverView.delegate = self
        
        let titleField = InputView(title: "Название сбора", placeholder: "Название сбора")
        stackView.addArrangedSubview(titleField)
        fieldList.append(titleField)
        
        var howMuchField:InputView!
        
        switch type {
        case .celevoi:
            howMuchField = InputView(title: "Сумма, ₽", placeholder: "Сколько нужно собрать?")
        case .regular:
            howMuchField = InputView(title: "Сумма в месяц, ₽", placeholder: "Сколько нужно в месяц?")
        }
        
        howMuchField.textField.keyboardType = .numberPad
        fieldList.append(howMuchField)
        
        stackView.addArrangedSubview(howMuchField)
        
        let taskField = InputView(title: "Цель", placeholder: "Например, поддержка приюта")
        stackView.addArrangedSubview(taskField)
        fieldList.append(taskField)
        
        let decsField = InputView(title: "Описание", placeholder: "На что пойдут деньги и как они кому-то помогут?", isMultiLine: true)
        stackView.addArrangedSubview(decsField)
        fieldList.append(decsField)
        
        let cardField = InputView(title: "Куда получать деньги", placeholder: "Счёт VK Pay · 1234", isWithChevron: true)
        cardField.setValue(text: "Счёт VK Pay · 1234")
        stackView.addArrangedSubview(cardField)
        fieldList.append(cardField)
        
        if type == .regular {
            let authorField = InputView(title: "Автор", placeholder: "Матвей Правосудов", isWithChevron: true)
            authorField.setValue(text: "Матвей Правосудов")
            stackView.addArrangedSubview(authorField)
            fieldList.append(authorField)
        }
        
        var nextButton:VKButton!
        
        switch type {
        case .celevoi:
            nextButton = VKButton(text: "Далее") {
                self.navigationController?.pushViewController(ExtraStepViewController(), animated: true)
            }
        case .regular:
            nextButton = VKButton(text: "Создать сбор") {
                
            }
        }
        
        view.addSubview(nextButton)
        nextButton.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(12)
            make.trailing.equalToSuperview().offset(-12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-12)
        }
        
    }
    
    @objc private func checkData() {
        
    }
    
    private func setupPicker() {
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.modalPresentationStyle = .popover
        picker.isModalInPopover = true
    }
    
    private func selectTap() {
        let actions = UIAlertController(title: "Выберите источник", message: nil, preferredStyle: .actionSheet)
        
        actions.addAction(UIAlertAction(title: "Выбрать из галереи", style: .default, handler: { (_) in
            actions.dismiss(animated: true) {
                self.picker.sourceType = .photoLibrary
                self.present(self.picker, animated: true, completion: nil)
            }
            
        }))
        actions.addAction(UIAlertAction(title: "Cфотографировать", style: .default, handler: { (_) in
            actions.dismiss(animated: false) {
                #if targetEnvironment(simulator)
                // your simulator code
                #else
                    self.picker.sourceType = UIImagePickerController.SourceType.camera
                    self.picker.cameraCaptureMode = .photo
                    self.picker.cameraDevice = .rear
                #endif
                self.present(self.picker, animated: true, completion: nil)
            }
        }))
        actions.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: { (_) in
            actions.dismiss(animated: true, completion: nil)
        }))
        
        self.present(actions, animated: true, completion: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CreateFirstStepViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                
        if let image = info[.originalImage] as? UIImage {
            coverView.buildView(state: .selected(image: image))
        }
        picker.dismiss(animated: true, completion: nil)
    }
}

extension CreateFirstStepViewController: CoverDelegate {
    func onTap() {
        selectTap()
    }
    
}
